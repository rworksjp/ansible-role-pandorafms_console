# encoding: utf-8

pc_pkgname = attribute("pandorafms_console_package_name", default: "XXX")
pc_version = attribute("pandorafms_console_version", default: nil)
mysql_svc_name = attribute("mysql_service_name", default: "XXX")
http_svc_name = attribute("http_service_name", default: "XXX")
phantomjs_install_prefix = attribute("phantomjs_install_prefix", default: "XXX")

control 'variables' do
  describe pc_pkgname, "(value of `pc_pkgname' variable) " do
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

control 'selenium-test' do
  describe command("selenese-runner --driver phantomjs --phantomjs #{phantomjs_install_prefix}/bin/phantomjs /tmp/test.side") do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /Exit code: 0/ }
  end
end
