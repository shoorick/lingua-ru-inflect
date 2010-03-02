#!perl -T

use utf8;
use Test::More 'no_plan';

use Lingua::RU::Inflect qw/so ob/;

ok( ob('ухе')   eq 'об',  'ob: vowel' );
ok( ob('ели')   eq 'о',   'ob: iotified vowel' );
ok( ob('пне')   eq 'о',   'ob: consonant' );
ok( ob('мне')   eq 'обо', 'ob: exception' );

ok( so('осой')  eq 'с',  'so: vowel' );
ok( so('солью') eq 'с',  'so: s with vowel' );
ok( so('сном')  eq 'со', 'so: s with consonant' );