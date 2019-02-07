# encoding: utf-8

pc_pkgname = attribute("pandorafms_console_package_name", default: "XXX")
pc_version = attribute("pandorafms_console_version", default: nil)
pc_dbname = attribute("pandorafms_console_dbname", default: "XXX")
pc_dbhost = attribute("pandorafms_console_dbhost", default: "XXX")
pc_dbuser = attribute("pandorafms_console_dbuser", default: "XXX")
pc_dbpass = attribute("pandorafms_console_dbpass", default: "XXX")
pc_docroot = attribute("pandorafms_console_docroot", default: "XXX")
pc_homeurl = attribute("pandorafms_console_homeurl", default: "XXX")
pc_homeurl_static = attribute("pandorafms_console_homeurl_static", default: "XXX")
skip_initial_config = attribute("pandorafms_console_skip_initial_configuration", default: "XXX")
mysql_svc_name = attribute("mysql_service_name", default: "XXX")
http_svc_name = attribute("http_service_name", default: "XXX")
phantomjs_install_prefix = attribute("phantomjs_install_prefix", default: "XXX")

control 'variables' do
  describe pc_pkgname, "(value of `pc_pkgname' variable) " do
    it { should_not eq "XXX" }
  end
  describe skip_initial_config, "(value of `skip_initial_config' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_dbname, "(value of `pc_dbname' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_dbuser, "(value of `pc_dbuser' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_dbpass, "(value of `pc_dbpass' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_dbhost, "(value of `pc_dbhost' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_docroot, "(value of `pc_docroot' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_homeurl, "(value of `pc_homeurl' variable)" do
    it { should_not eq "XXX" }
  end
  describe pc_homeurl_static, "(value of `pc_homeurl_static' variable)" do
    it { should_not eq "XXX" }
  end
  describe mysql_svc_name, "(value of `mysql_svc_name' variable)" do
    it { should_not eq "XXX" }
  end
  describe http_svc_name, "(value of `http_svc_name' variable)" do
    it { should_not eq "XXX" }
  end
  describe phantomjs_install_prefix, "(value of `phantomjs_install_prefix' variable)" do
    it { should_not eq "XXX" }
  end
end

control 'apps' do
  describe package(pc_pkgname) do
    it { should be_installed }
  end
  describe package('php') do
    it { should be_installed }
  end
  describe command('selenese-runner --help') do
    its('stdout') { should match /Selenese Runner/ }
  end
end

control 'pandorafms_console-version' do
  only_if('pandorafms_console_version is specified') do
    not pc_version.nil?
  end
  describe package(pc_pkgname) do
    its('version') { should cmp = pc_version }
  end
end

control 'php-version' do
  only_if('Pandora FMS > 7.0NG.728') do
    pc_version.nil? or package(pc_pkgname).version >= "7.0NG.728" 
  end
  describe package('php') do
    its('version') { should cmp >= '7.0' }
  end
end

control 'services' do
  describe service(http_svc_name) do
    it { should be_running }
  end
  describe service(mysql_svc_name) do
    it { should be_running }
  end
end

control 'pandorafms_console-config.php' do
  describe file(File.join(pc_docroot,'include','config.php')) do
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["dbname"]="#{pc_dbname}";|)}/ }
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["dbuser"]="#{pc_dbuser}";|)}/ }
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["dbpass"]="#{pc_dbpass}";|)}/ }
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["dbhost"]="#{pc_dbhost}";|)}/ }
#{% if pandorafms_console_dbport != omit %}
#$config["dbhost"]="{{ pandorafms_console_dbhost }}";	// DB Port
#{% endif %}
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["homedir"]="#{pc_docroot}/";|)}/ }
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["homeurl"]="#{pc_homeurl}/";|)}/ }
    its('content') { should match /(?<!\/\/)\s*#{Regexp.escape(%Q|$config["homeurl_static"]="#{pc_homeurl_static}/";|)}/ }
  end
end

control 'selenium-test' do
  describe command("selenese-runner --driver phantomjs --phantomjs #{phantomjs_install_prefix}/bin/phantomjs /tmp/test.side") do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /Exit code: 0/ }
  end
end
