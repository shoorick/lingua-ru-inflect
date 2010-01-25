package Lingua::RU::Inflect::Exceptions;

use warnings;
use strict;
use utf8;

our $VERSION = '0.01';

=head1 NAME

Lingua::RU::Inflect::Exceptions — Exception lists
for Lingua::RU::Inflect.

=head1 VERSION

0.01

=head1 DESCRIPTION

Contains list of bashkir, jewish, russian, tatar names.

C<@MASCULINE_NAMES> contains masculine names
which ends to vowels.

C<@FEMININE_NAMES> contains masculine names
which ends to consonants.

=cut

our @MASCULINE_NAMES   = qw(
    Аба
    Азарья
    Акива
    Аккужа
    Аникита
    Аса
    Байгужа
    Вафа
    Габдулла
    Габидулла
    Гаврила
    Гадельша
    Гайнулла
    Гайса
    Гайфулла
    Галиулла
    Гата
    Гдалья
    Гийора
    Гиля
    Гошеа
    Данила
    Джиханша
    Зайнулла
    Закария
    Зия
    Зосима
    Зхарья
    Зыя
    Идельгужа
    Иешуа
    Ильмурза
    Илья
    Иона
    Исайя
    Иуда
    Йегошуа
    Йегуда
    Йедидья
    Карагужа
    Кузьма
    Лука
    Марданша
    Мина
    Мирза
    Миха
    Мойша
    Муртаза
    Муса
    Мусса
    Мустафа
    Никита
    Нэта
    Нэхэмья
    Овадья
    Птахья
    Рахматулла
    Риза
    Савва
    Сафа
    Сила
    Симха
    Сэадья
    Товия
    Фока
    Фома
    Хамза
    Хананья
    Цфанья
    Шалва
    Шахна
    Шрага
    Эзра
    Элиша
    Элькана
    Юмагужа
    Ярулла
    Яхья
);

our @FEMININE_NAMES = qw(
    Айгуль
    Айгюль
    Айзиряк
    Альфинур
    Асылгюль
    Бадар
    Бадиян
    Банат
    Бедер
    Бибикамал
    Бибинур
    Гайниджамал
    Гайникамал
    Гаухар
    Гиффат
    Гулендем
    Гульбадиян
    Гульдар
    Гульджамал
    Гульджихан
    Гульехан
    Гульзар
    Гулькей
    Гульназ
    Гульнар
    Гульнур
    Гульсем
    Гульсесек
    Гульсибар
    Гульчачак
    Гульшат
    Гульшаян
    Гульюзум
    Гульямал
    Гюзель
    Джамал
    Джаухар
    Джихан
    Дильбар
    Диляфруз
    Зайнаб
    Зайнап
    Зейнаб
    Зубарджат
    Зуберьят
    Ильсёяр
    Камяр
    Карасес
    Кямар
    Любовь
    Ляйсан
    Магинур
    Магруй
    Марьям
    Минджихан
    Минлегюль
    Миньеган
    Наркас
    Нинель
    Нурджиган
    Райхан
    Раушан
    Рахель
    Рахиль
    Рут
    Руфь
    Рэйчел
    Сагадат
    Сагдат
    Сарбиназ
    Сарвар
    Сафин
    Сахибджамал
    Сулпан
    Сумбуль
    Сурур
    Сюмбель
    Сясак
    Тамар
    Тансулпан
    Умегульсум
    Уммегюльсем
    Фарваз
    Фархинур
    Фирдаус
    Хаджар
    Хажар
    Хаят
    Хуршид
    Чечек
    Чулпан
    Шамсинур
    Юдифь
    Юндуз
    Ямал
);

1;

=head1 SEE ALSO

L<http://www.imena.org/declension.html> (in Russian)

=head1 AUTHOR

Alexander Sapozhnikov, C<< <shoorick at cpan.org> >>

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut
