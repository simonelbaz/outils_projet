use strict;
use File::Copy;
use File::Find;

my $x_env=$ARGV[0];
my $a_zone=$ARGV[1];
my @tab_val;

sub init_module {
	my $module_dir = "/home/exportjob/install/module/".lc($a_zone)."/";

	print "module dir:".$module_dir."\n";
	my @dir_to_lookfor;

	push @dir_to_lookfor, $module_dir; 
	File::Find::find({wanted => \&wanted_init}, @dir_to_lookfor);

}

sub scan_module {
	@tab_val = split '=';
	my $module_dir = "/home/exportjob/install/module/".lc($a_zone)."/";
	print "module dir:".$module_dir."\n";
	my @dir_to_lookfor;
	push @dir_to_lookfor, $module_dir; 

	File::Find::find({wanted => \&wanted}, @dir_to_lookfor);
}

sub wanted_init {

	if (m/^.*\.erb$/)
	{
		print "wanted_init:".$_."\n";
		my $a_file_copied = $File::Find::name;
		$a_file_copied =~ s/.erb$/.curr/;
		copy($File::Find::name, $a_file_copied) or die "Couldn't copy: $!";
	}
}

sub wanted {
	print "File before:".$_."\n";
	if (m/^.*\.erb$/)
	{
		print "File after:".$_."\n";
		my $a_file_replaced = $File::Find::name;
		$a_file_replaced =~ s/.erb$/.curr/;
		my $a_working_file = $File::Find::name;
		$a_working_file =~ s/.erb$/.tmp/;
		open(my $tmp_fh, "<", $a_file_replaced) || die "can't open file $a_file_replaced: $!";
		open(my $fh_towrite, ">", $a_working_file) || die "can't open file $a_working_file: $!";
		while(my $a_line = <$tmp_fh>)
		{
			chomp $a_line;
			if($a_line =~ m/<%= $tab_val[0] %>/)
			{
				print "before:".$a_line."\n";
				$a_line =~ s/<%= $tab_val[0] %>/$tab_val[1]/;
				print "after:".$a_line."\n";
			}
			print { $fh_towrite } $a_line."\n";
		}
		close($fh_towrite);
		close($tmp_fh);
		move($a_working_file, $a_file_replaced) or die "Couldn't move: $!";
	}
}

print "x_env:".$x_env."\n";

init_module;
open(my $fh, "<", $x_env);

my $debut_zone=0;
while(<$fh>)
{
	chomp;
	if( $_ eq "[".$a_zone."]")
	{
		print "debut zone trouvee\n";
		$debut_zone = 1;
	}
	elsif ( substr($_, 0, 1) eq "[" )
	{
		$debut_zone = 0;
	}

	if ( ($debut_zone == 1) && (substr($_, 0, 1) ne "[" ) )
	{
		print "variable en cours:".$_."\n";
		scan_module $_;
	}

	if ( ($debut_zone == 1) && (substr($_, 0, 1) eq "[" ) && ( $_ ne "[".$a_zone."]" ) )
	{
		print "fin zone\n";
		$debut_zone = 2;
	}
}

close($fh);
