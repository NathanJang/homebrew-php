require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ev < AbstractPhp56Extension
  init
  homepage 'https://pecl.php.net/package/ev'
  url 'https://pecl.php.net/get/ev-0.2.10.tgz'
  sha256 'a71757b452fdf66bbb50ac8c5e28c55ab1412f6436958e77888269552d2fd6a3'
  head 'https://bitbucket.org/osmanov/pecl-ev.git'

  bottle do
    cellar :any_skip_relocation
    sha256 "4ffac8ecfeae66dddd9a8405bcaeffa050bad7df1a49c362c219b30a15a8dc19" => :mavericks
  end

  depends_on 'libev'

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula['libev'].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
