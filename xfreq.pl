use XML::LibXML;
use IO::Handle;

# initialize the parser
my $parser = new XML::LibXML;

# open a filehandle and parse
my $fh = new IO::Handle;
if( $fh->fdopen( fileno( STDIN ), "r" )) {
	my $doc = $parser->parse_fh( $fh );
	my $dist;
	&proc_node( $doc->getDocumentElement, \%dist );
	foreach my $item ( sort keys % dist ) {
		print "$item: ", $dist{ $item }, "\n";
	}
	$fh->close;
}

# process an XML tree node: if it's an element, update the
# distributtion list and process all its children

sub proc_node {
	my( $node, $dist ) = @_;
	return unless( $node->nodeType eq &XML_ELEMENT_NODE );
	$dist->{ $node->nodeName } ++;
	foreach my $child ( $node->getChildnodes ) {
		&proc_node( $child, $dist );
	}
}