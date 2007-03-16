# $Id: Makefile.PL,v 1.1 2007/03/16 17:16:14 dk Exp $
use 5.008008;
use ExtUtils::MakeMaker;

my ( $i, $d, $l) = ('','','');
eval { 
	require Prima::Config;
	$d = join(' ', map { "-D$_" } @{$Prima::Config::Config{cdefs}});
	$i = join(' ', map { "-I$_" } @{$Prima::Config::Config{incpaths}});
	$l = $Prima::Config::Config{libname} if $^O =~ /win32|os2/i;
};

WriteMakefile(
	NAME              => 'Prima::Image::Magick',
	VERSION_FROM      => 'lib/Prima/Image/Magick.pm',
	PREREQ_PM         => {
		'Prima'		=> 1,
		'Image::Magick' => 1,
	},
	ABSTRACT_FROM     => 'lib/Prima/Image/Magick.pm',
	AUTHOR            => 'Dmitry Karasik <dmitry@karasik.eu.org>',
	LIBS              => [ $l . ' -lMagick' ],
	DEFINE            => $d,
	INC               => $i,
	OBJECT            => "prima\$(OBJ_EXT) mag\$(OBJ_EXT) Magick\$(OBJ_EXT)",
);
