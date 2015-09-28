# == Class: grandperspective
#
# Install GrandPerspective
#
class grandperspective (
) {
  package { 'grandperspective':
    provider => 'brewcask'
  }
}
