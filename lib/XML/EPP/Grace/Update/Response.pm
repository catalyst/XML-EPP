
package XML::EPP::Grace::Update::Response;

use Moose;
use PRANG::Graph;

extends 'XML::EPP::Grace::Data';
with 'XML::EPP::Grace';

sub root_element {
	"upData";
}

1;
