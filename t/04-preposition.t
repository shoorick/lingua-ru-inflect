#!perl -T

use utf8;
use Test::More 'no_plan';

use Lingua::RU::Inflect;
*p  = \&Lingua::RU::Inflect::choose_preposition_by_next_word;

ok( p('о', 'ухе')  eq 'об',  'o/ob/obo: vowel' );
ok( p('о', 'ели')  eq 'о',   'o/ob/obo: iotified vowel' );
ok( p('о', 'пне')  eq 'о',   'o/ob/obo: consonant' );
ok( p('о', 'мне')  eq 'обо', 'o/ob/obo: exception - mne' );

ok( p('с', 'осой')  eq 'с',  's/so: vowel' );
ok( p('с', 'сном')  eq 'со', 's/so: s with consonant' );
ok( p('с', 'солью') eq 'с',  's/so: s with vowel' );
ok( p('с', 'мной')  eq 'со', 's/so: exception - mnoi' );

ok( p('в', 'вилке')    eq 'в',  'v/vo: v with vowel' );
ok( p('в', 'впадине')  eq 'во', 'v/vo: v with consonant' );
ok( p('в', 'всаднике') eq 'во', 'v/vo: v with consonant' );
ok( p('в', 'мне')      eq 'во', 'v/vo: exception - mne' );
