use XML::XPath;
 my $file = 'customers.xml';
 my $xp = XML::XPath->new(filename=>$file);
 # An XML::XPath nodeset is an object which contains the result of
 # smacking an XML document with an XPath expression; we'll do just
 # this, and then query the nodeset to see what we get.
 my $nodeset = $xp->find('//zip');
 my @zipcodes;                   # Where we'll put our results
 if (my @nodelist = $nodeset->get_nodelist) {
   # We found some zip elements! Each node is an object of the class
   # XML::XPath::Node::Element, so I'll use that class's 'string_value'
   # method to extract its pertinent text, and throw the result for all
   # the nodes into our array.
     @zipcodes = map($_->string_value, @nodelist);
  # Now sort and prepare for output
  @zipcodes = sort(@zipcodes);
  local $" = "\n";
  print "I found these zipcodes:\n@zipcodes\n";
} else {
  print "The file $file didn't have any 'zip' elements in it!\n";
}