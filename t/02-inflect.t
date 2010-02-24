#!perl -T

use utf8;
use Test::More 'no_plan';

use Lingua::RU::Inflect ':all';

my $M = Lingua::RU::Inflect::MASCULINE;
my $F = Lingua::RU::Inflect::FEMININE;
my $s = \&Lingua::RU::Inflect::inflect_given_name;

# Masculine names
ok( join(' ', &$s( NOMINATIVE, 'Пупкин', 'Василий', 'Алибабаевич' ))
    eq 'Пупкин Василий Алибабаевич',
    'Nominative of any name must be same as name' );
ok( join(' ', &$s( GENITIVE, 'Иванов', 'Сергей', 'Михайлович' ))
    eq 'Иванова Сергея Михайловича',
    'Genitive of usual russian masculine name: Sergey Mikhailovich Ivanov' );
ok( join(' ', &$s( DATIVE, 'Ильин', 'Роман' ))
    eq 'Ильину Роману ',
    'Dative of usual russian masculine name without patronym: Roman Ilyin' );
ok( join(' ', &$s( ACCUSATIVE, undef, undef, 'Михалыч' ))
    eq '  Михалыча',
    'Accusative of vulgar form of russian patronym: Mikhalych' );
ok( join(' ', &$s( INSTRUMENTAL, 'Пушкин', undef, 'Сергеич' ))
    eq 'Пушкиным  Сергеичем',
    'Instrumental case of lastname with vulgar form of patronym: Pushkin Sergeich' );
ok( join(' ', &$s( INSTRUMENTAL, 'Чайковский', 'Пётр', 'Ильич' ))
    eq 'Чайковским Петром Ильичом',
    'Instrumental case of special firstname (yo -> e) and patronym: Tchaikovsky Pyotr Ilyich' );
ok( join(' ', &$s( PREPOSITIONAL, 'Репка', 'Илья' ))
    eq 'Репке Илье ',
    'Prepositional case of masculine name ends to vowels without patronym: Ilya Repka' );
ok( join(' ', &$s( GENITIVE, 'Ушко', 'Микола' ))
    eq 'Ушко Миколы ',
    'Genitive of ukrainian masculine name ends to vowels without patronym: Mykola Ushko' );
ok( join(' ', &$s( DATIVE, 'Косой', 'Вася' ))
    eq 'Косому Васе ',
    'Dative of name of boy ends to vowels without patronym: Vasya Kosoy' );
ok( join(' ', &$s( ACCUSATIVE, 'Балаганов', 'Шура' ))
    eq 'Балаганова Шуру ',
    'Accusative of ambiguous name, whose gender detected by lastname: Shura Balaganov' );
ok( join(' ', &$s( INSTRUMENTAL, 'Уолл', 'Ларри' ))
    eq 'Уоллом Ларри ',
    'Instrumental case of english masculine name: Larry Wall' );
# Too complex. Wait for next version.
# ok( join(' ', &$s( PREPOSITIONAL, 'Бах', 'Иоганн Себастьян' ))
#     eq 'Бахе Иоганне Себастьяне ',
#     'Prepositional case of german masculine name: Johann Sebastian Bach' );
# ok( join(' ', &$s( GENITIVE, 'фон Вебер', 'Карл Мария' ))
#     eq 'фон Вебера Карла Марии ',
#     'Genitive of german mixed name with prefix: Carl Maria von Weber' );
# ok( join(' ', &$s( DATIVE, 'Руссо', 'Жан-Жак' ))
#     eq 'Руссо Жан-Жаку ',
#     'Dative of masculine name with hyphen: Jean-Jacques Rousseau' );

# Feminine names
ok( join(' ', &$s( ACCUSATIVE, 'Волкова', 'Анна', 'Павловна' ))
    eq 'Волкову Анну Павловну',
    'Accusative of usual russian feminine name: Anna Pavlovna Volkova' );
ok( join(' ', &$s( INSTRUMENTAL, 'Соколова', 'Инна' ))
    eq 'Соколовой Инной ',
    'Instrumental case of russian feminine name without patronym: Inna Sokolova' );
ok( join(' ', &$s( PREPOSITIONAL,  undef, 'Маргарита', 'Пална' ))
    eq ' Маргарите Палне',
    'Prepositional case of russian feminine firstname with vulgar form of patronym: Margarita Palna' );
ok( join(' ', &$s( GENITIVE,  'Шевчук', 'Любовь' ))
    eq 'Шевчук Любови ',
    'Genitive of russian feminine name ends to consonants: Lyubov Shevchuk' );
ok( join(' ', &$s( DATIVE, 'Купер', 'Элис' ))
    eq 'Купер Элис ',
    'Dative of english feminine name ends to consonants: Alice Cooper' );
ok( join(' ', &$s( ACCUSATIVE, 'Петрова', 'Женя' ))
    eq 'Петрову Женю ',
    'Accusative of ambiguous name, detect by lastname: Zhenya Petrova' );
# Too complex. Wait for next version.
# ok( join(' ', &$s( INSTRUMENTAL, 'Фишер', 'Анна-Мария' ))
#     eq 'Фишер Анну-Марию ',
#     'Instrumental case of feminine name with hyphen: Anna-Maria Fisher' );

# Ambigous names
# How to decline?
ok( join(' ', &$s( PREPOSITIONAL, 'Кац', 'Саша' ))
    eq 'Кац Саше ',
    'Prepositional of ambiguous name: Sasha Katz' );
