
package XML::EPP::Grace::Info;

use Moose;
use PRANG::Graph;

extends 'XML::EPP::Grace::Data';
with 'XML::EPP::Grace';

sub root_element {
	"infData";
}

1;
