require 'formula'

class Acedb <Formula
  url 'ftp://ftp.sanger.ac.uk/pub2/wormbase/data/acedb-4.9.54.tar.bz2'
  homepage 'http://www.acedb.org'
  md5 '3b977163ac76b4f5e1e0c1718c45c8fe'

  depends_on 'gtk+'

  def install
    
    #custome compile environments to build on Darwin
    ENV['ACEDB']=prefix
    ENV['ACEDB_MACHINE']='DARWIN_4'
	
	
	  chmod_R 0755, 'wmake'
	  chmod 0755, 'makefile'

	  # gtk+ path is dependent on homebrew
	  inreplace 'wmake/DARWIN_4_DEF' do |s|
	    s.change_make_var! 'PKGPATH',"-local #{HOMEBREW_PREFIX}"
	  end
	
	  # acembly doesn't compile (yet), so removed from install target
	  inreplace 'makefile' do |s|
	    s.change_make_var! 'INSTALL_BIN','$(ACE_BIN) $(ALIGN_BIN) $(OTHER_BIN) $(TOOLS_BIN)'
	  end

	  system 'make'
    system 'make install'
  end
end