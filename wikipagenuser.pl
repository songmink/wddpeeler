use warnings;
use strict;
use XML::Twig;

# file input on a command line
#my $file = $ARGV[0];
my $file = 'enwiki-20160204-pages-meta-history1-02.xml';

my $twigPage = XML::Twig->new(twig_handlers => {page => \&title});
$twigPage->parsefile($file);

sub title {
	my ($twig_obj, $page_element) = @_;
	print $page_element->first_child('title')->text(), "\n";
	print "\n";
}

my $twigUser = XML::Twig->new(twig_handlers => {contributor => \&contributor});
$twigUser->parsefile($file);

sub contributor {
	my ($twig_obj, $contributor_element) = @_;
	if($contributor_element->children('id')){
		print $contributor_element->first_child('id')->text(), "\t";
		print $contributor_element->first_child('username')->text(), "\n";
	}
	if($contributor_element->children('ip')){
		print $contributor_element->first_child('ip')->text(), "\n";
	}
}