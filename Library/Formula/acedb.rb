require 'formula'

class Acedb <Formula
  url 'ftp://ftp.sanger.ac.uk/pub2/wormbase/data/acedb-4.9.56.2.tar.bz2'
  homepage 'http://www.acedb.org'
  md5 '9ce9c2f5487632460ea6fe9dff678d83'

  depends_on 'gtk+'
  depends_on 'libiconv' # hmm .... ???
  depends_on 'readline' # somehow defaults to libedit

  def install
    
    #custom compile environments to build on Darwin
    ENV['ACEDB']=prefix
    ENV['ACEDB_MACHINE']='DARWIN_MACPORTS_64'


    chmod_R 0755, 'wmake'
    chmod 0755, 'makefile'

    # gtk+ path is dependent on homebrew
    inreplace 'wmake/DARWIN_MACPORTS_64_DEF' do |s|
      s.change_make_var! 'LOCAL_LIBS',HOMEBREW_PREFIX
    end

    # acembly doesn't compile (yet), so removed from install target
    inreplace 'makefile' do |s|
      s.change_make_var! 'INSTALL_BIN','$(ACE_BIN) $(ALIGN_BIN) $(OTHER_BIN) $(TOOLS_BIN)'
    end

    system 'make'
    system 'make install'
  end
end
