package Lingua::RU::Inflect;

use warnings;
use strict;
use utf8;

=head1 NAME

Lingua::RU::Inflect — Inflect russian names.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


BEGIN {
    use Exporter   ();
    our ($VERSION, @ISA, @EXPORT, @EXPORT_OK, %EXPORT_TAGS);

    # set the version for version checking
    $VERSION     = 0.01;

    @ISA         = qw(Exporter);
    @EXPORT      = qw(&decline);
    %EXPORT_TAGS = ( );     # eg: TAG => [ qw!name1 name2! ],

    # your exported package globals go here,
    # as well as any optionally exported functions
    @EXPORT_OK   = qw(
        $NOMINATIVE $GENITIVE     $DATIVE
        $ACCUSATIVE $INSTRUMENTAL $PREPOSITIONAL
        %CASES
    );
}

use List::MoreUtils 'mesh';

# Gender
our ( $FEMALE, $MALE ) = ( 0, 1 );

# Падежи
my  @CASE_NAMES = qw(
    NOMINATIVE GENITIVE DATIVE ACCUSATIVE INSTRUMENTAL PREPOSITIONAL
);
my  @CASE_NUMBERS = ( -1 .. 4 );

our (
    $NOMINATIVE, $GENITIVE, $DATIVE, $ACCUSATIVE, $INSTRUMENTAL, $PREPOSITIONAL
) = @CASE_NUMBERS;

our %CASES = mesh @CASE_NAMES, @CASE_NUMBERS;



=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Lingua::RU::Inflect;

    my $foo = Lingua::RU::Inflect->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

=head2 detect_gender

Try to detect gender by name. Up to three arguments expected:
lastname, firstname, patronym.

Return C<$MALE>, C<$FEMALE> for successful detection
or C<undef> when function can't detect gender.

Most of russian feminine firstnames ends to vowels “a” and “ya”.
Most of russian masculine firstnames ends to consonants.

=cut

sub detect_gender {
    my ( $lastname, $firstname, $surname ) = @_;
    map { $_ ||= '' } ( $lastname, $firstname, $surname );

    # Detect by patronym
    return $FEMALE if $surname =~ /на$/;
    return   $MALE if $surname =~ /[иы]ч$/;

    # Detect by firstname
    # Process exceptions
    foreach my $name ( @Exceptions::MASCULINE_NAMES ) {
        return $MALE if $firstname eq $name;
    }

    foreach my $name ( @Exceptions::FEMININE_NAMES ) {
        return $FEMALE if $firstname eq $name;
    }
    # Feminine firstnames ends to vowels
    return $FEMALE if $firstname =~ /[аеёиоуыэюя]$/;

    # Detect by lastname
    # possessive names
    return $FEMALE if $lastname =~ /(ин|ын|ёв|ов)а$/;
    return   $MALE if $lastname =~ /(ин|ын|ёв|ов)$/;
    # adjectives
    return $FEMALE if $lastname =~ /(ая|яя)$/;
    return   $MALE if $lastname =~ /(ий|ый)$/;

}

=head2 _inflect_name

Inflect name of given gender to given case.
Up to 5 arguments expected: gender, case, lastname, firstname, patronym.
Lastname, firstname, patronym must be in Nominative.

Return list contains inflected lastname, firstname, patronym.

=cut

sub _inflect_name {
    my $gender = shift;
    my $case   = shift;

    return
        if $case < $GENITIVE
        || $case > $PREPOSITIONAL;

    my ( $lastname, $firstname, $surname ) = @_;
    map { $_ ||= '' } ( $lastname, $firstname, $surname );

    # Patronyms
    $surname =~ s/на$/qw(ны не ну ной не)[$case]/e;
    $surname =~ s/ич$/qw(ича ичу ича ичем иче)[$case]/e;
    $surname =~ s/ыч$/qw(ыча ычу ыча ычем ыче)[$case]/e;

    # Firstnames
    {
        # Exceptions
        $firstname =~ s/^Пётр$/Петр/;

        # Names which ends to vowels “o”, “yo”, “u”, “yu”, “y”, “i”, “e”, “ye”
        # and to pairs of vowels except “yeya”, “iya”
        # can not be inflected

        last if $firstname =~ /[еёиоуыэю]$/i;
        last if $firstname =~ /[аеёиоуыэюя]а$/i;
        last if $firstname =~ /[аёоуыэюя]я$/i;

        last if $firstname =~ s/ия$/qw(ии ии ию ией ие)[$case]/e;
        last if $firstname =~ s/а$/qw(ы е у ой е)[$case]/e;
        last if $firstname =~ s/я$/qw(и е ю ей е)[$case]/e;
        last if $firstname =~ s/й$/qw(я ю я ем е)[$case]/e;

        # Same endings, but different gender
        if ( $gender == $MALE ) {
            last if $firstname =~ s/ь$/qw(я ю я ем е)[$case]/e;
        }
        elsif ( $gender == $FEMALE ) {
            last if $firstname =~ s/ь$/qw(и и ь ью и)[$case]/e;
        }

        # Rest of names which ends to consonants
        $firstname .= qw(а у а ом е)[$case];
    } # Firstnames

    # Lastnames
    {
        # Indeclinable
        last if $lastname =~ /[еёиоуыэю]$/i;
        last if $lastname =~ /[аеёиоуыэюя]а$/i;
        last if $lastname =~ /[ёоуыэю]я$/i;
        # Lastnames such as “Belaya” and “Sinyaya”
        #  which ends to “aya” and “yaya” must be inflected

        # Feminine lastnames
        last
            if $lastname =~ /(ин|ын|ев|ёв|ов)а$/
            && $lastname =~ s/а$/qw(ой ой у ой ой)[$case]/e;

        # And masculine ones
        last
            if $lastname =~ /(ин|ын|ев|ёв|ов)$/
            && ( $lastname .= qw(а у а ым е)[$case] );

        # As adjectives
        last if $lastname =~ s/ая$/qw(ой ой ую ой ой)[$case]/e;
        last if $lastname =~ s/яя$/qw(ей ей юю ей ей)[$case]/e;
        last if $lastname =~ s/кий$/qw(кого кому кого ким ком)[$case]/e;
        last if $lastname =~ s/ий$/qw(его ему его им ем)[$case]/e;
        last if $lastname =~ s/ый$/qw(ого ому ого ым ом)[$case]/e;
        last if $lastname =~ s/ой$/qw(ого ому ого ым ом)[$case]/e;

        # Rest of masculine lastnames
        if ( $gender == $MALE ) {
            last if $lastname =~ s/а$/qw(ы е у ой е)[$case]/e;
            last if $lastname =~ s/я$/qw(и е ю ёй е)[$case]/e;
            last if $lastname =~ s/й$/qw(я ю й ем е)[$case]/e;
            last if $firstname =~ s/ь$/qw(я ю я ем е)[$case]/e;
            $lastname .= qw(а у а ом е)[$case];
        } # if
    } # Lastnames

    return ( $lastname, $firstname, $surname );
} # sub _inflect_name


=head2 inflect_name

Определяет пол и склоняет имя.
Входные параметры — падеж, фамилия, имя, отчество.
Возвращает список — фамилию, имя, отчество.

=cut

sub inflect_name {
    my $case = shift;
    my @name = _inflect_name( detect_gender( @_ ), $case, @_ );
} # sub inflect_name

=head1 SEE ALSO

L<http://www.imena.org/declension.html> (in Russian)

=head1 AUTHOR

Alexander Sapozhnikov, C<< <shoorick at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lingua-ru-inflect at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lingua-RU-Inflect>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::RU::Inflect


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-RU-Inflect>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lingua-RU-Inflect>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-RU-Inflect>

=item * Search CPAN

L<http://search.cpan.org/dist/Lingua-RU-Inflect/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Alexander Sapozhnikov.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Lingua::RU::Inflect
