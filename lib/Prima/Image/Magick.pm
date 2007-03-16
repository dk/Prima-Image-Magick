# $Id: Magick.pm,v 1.1 2007/03/16 17:16:14 dk Exp $
package Prima::Image::Magick;

use strict;
use warnings;
require Exporter;
our @ISA         = qw(Exporter);
our @EXPORT_OK   = qw( prima_to_magick magick_to_prima );
our %EXPORT_TAGS = ( all => \@EXPORT_OK );
our $VERSION     = '0.01';

require XSLoader;
XSLoader::load('Prima::Image::Magick', $VERSION);

use Prima;
use Image::Magick;

sub prima_to_magick
{
	my ( $p) = @_;
	die "Not a Prima::Image object" unless $p and $p->isa('Prima::Image');
	my $m = Image::Magick-> new();
	convert_to_magick( $p, $m);
	$m;
}

sub magick_to_prima
{
	my ( $m, %h) = @_;
	die "Not an Image::Magick object" unless $m and $m->isa('Image::Magick');
	my $p = Prima::Image-> new;
	convert_to_prima( $m, $p);
	$p;
}

1;
__END__

=head1 NAME

Prima::Image::Magick - Juggle images between Prima and Image::Magick.

=head1 SYNOPSIS

  use Prima::Image::Magick qw(:all);

  use Prima qw(Application MsgBox);
  use Image::Magick;

=head1 DESCRIPTION

Juggle images between L<Prima> and L<Image::Magick>. Defines two
simple converters, C<prima_to_magick> and C<magick_to_prima>,
that can be exported either individually or with the C<:all> tag.

=head1 SEE ALSO

L<Prima>, L<Image::Magick>.

=head1 AUTHOR

Dmitry Karasik, E<lt>dmitry@karasik.eu.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Dmitry Karasik

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut
