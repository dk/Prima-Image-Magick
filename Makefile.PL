# $Id: Makefile.PL,v 1.6 2012/01/03 16:48:41 dk Exp $
use 5.008008;
use ExtUtils::MakeMaker;

my ( $i, $d, $l) = ('','','');
eval { 
	require Prima::Config;
	$d = join(' ', map { "-D$_" } @{$Prima::Config::Config{cdefs}});
	$i = join(' ', map { "-I$_" } @{$Prima::Config::Config{incpaths}});
        for ( '/usr/include', @{$Prima::Config::Config{incpaths}}) {
                $i .= " -I$_/ImageMagick" if -d "$_/ImageMagick";
        }
	$l = $Prima::Config::Config{libname} if $^O =~ /win32|os2/i;
};

my $libname;
if ( $^O =~ /win32/i) {
	$libname = 'CORE_RL_magick_';
} else {
	$libname = 'MagickCore';
	if ( 
		`convert -version` =~ /Version: ImageMagick (\d+\.\d+\.\d+)/ 
	) {
		my $v = $1;
		$v =~ s/\.//g;
		$libname = 'Magick' if $v < 641;
	}
}

WriteMakefile(
	NAME              => 'Prima::Image::Magick',
	VERSION_FROM      => 'lib/Prima/Image/Magick.pm',
	PREREQ_PM         => {
		'Prima'		=> 1,
		'Image::Magick' => 1,
	},
	ABSTRACT_FROM     => 'lib/Prima/Image/Magick.pm',
	AUTHOR            => 'Dmitry Karasik <dmitry@karasik.eu.org>',
	LIBS              => [ "$l -l$libname" ],
	DEFINE            => $d,
	INC               => $i,
	OBJECT            => "prima\$(OBJ_EXT) mag\$(OBJ_EXT) Magick\$(OBJ_EXT)",
);
