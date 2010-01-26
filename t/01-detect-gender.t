#!perl -T

use utf8;
use Test::More 'no_plan';

BEGIN {
    use_ok('Lingua::RU::Inflect');
}

my $M = $Lingua::RU::Inflect::MASCULINE;
my $F = $Lingua::RU::Inflect::FEMININE;
my $d = \&Lingua::RU::Inflect::detect_gender;

# Masculine names
ok( &$d( 'Иванов', 'Сергей', 'Михайлович' ) == $M,
    'usual russian masculine name: Sergey Mikhailovich Ivanov' );
ok( &$d( 'Ильин', 'Роман' ) == $M,
    'usual russian masculine name without patronym: Roman Ilyin' );
ok( &$d( 'Репка', 'Илья' ) == $M,
    'russian masculine name ends to vowels without patronym: Ilya Repka' );
ok( &$d( 'Ушко', 'Микола' ) == $M,
    'ukrainian masculine name ends to vowels without patronym: Mykola Ushko' );
ok( &$d( 'Косой', 'Вася' ) == $M,
    'name of boy ends to vowels without patronym: Vasya Kosoy' );
ok( &$d( 'Балаганов', 'Шура' ) == $M,
    'ambiguous name, detect by lastname: Shura Balaganov' );
ok( &$d( 'Уолл', 'Ларри' ) == $M,
    'english masculine name: Larry Wall' );
ok( &$d( 'Бах', 'Иоганн Себастьян' ) == $M,
    'german masculine name: Johann Sebastian Bach' );
ok( &$d( 'фон Вебер', 'Карл Мария' ) == $M,
    'german masculine name: Carl Maria von Weber' );

# Feminine names
ok( &$d( 'Волкова', 'Анна', 'Павловна' ) == $F,
    'usual russian feminine name: Anna Pavlovna Volkova' );
ok( &$d( 'Соколова', 'Инна' ) == $F,
    'russian feminine name without patronym: Inna Sokolova' );
ok( &$d( 'Шевчук', 'Любовь' ) == $F,
    'russian feminine name ends to consonants: Lyubov Shevchuk' );
ok( &$d( 'Купер', 'Элис' ) == $F,
    'foreign feminine name ends to consonants: Alice Cooper' );
ok( &$d( 'Петрова', 'Женя' ) == $F,
    'ambiguous name, detect by lastname: Zhenya Petrova' );

# Wrong names
ok( !defined( &$d( 'Хренова', 'Гадя', 'Петрович' ) ),
    'wrong name: Gadya Petrovich Khrenova' );

# Ambigous names
ok( !defined( &$d( 'Кац', 'Саша' ) ),
    'ambiguous name: Sasha Katz' );
