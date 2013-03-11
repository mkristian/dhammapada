#-*- mode: ruby -*-

# could be already declared in the Jarfile
jar("org.jruby.rack:jruby-rack", '1.1.13.1') unless jar?("org.jruby.rack:jruby-rack")

jar("org.jruby:jruby-core", "${jruby.version}")
jar('com.google.gwt:gwt-user', '${gwt.version}').scope :provided

jar('de.mkristian.gwt:rails-gwt', '0.8.0-SNAPSHOT').scope :provided
jar('org.fusesource.restygwt:restygwt', '1.3-SNAPSHOT').scope :provided
jar('javax.ws.rs:jsr311-api', '1.1').scope :provided
jar('com.google.gwt.inject:gin', '1.5.0').scope :provided
jar('javax.validation:validation-api', '1.0.0.GA').scope :provided
jar('javax.validation:validation-api', '1.0.0.GA', 'sources').scope :provided

plugin('org.codehaus.mojo:gwt-maven-plugin', '${gwt.version}') do |gwt|
  gwt.with({ :warSourceDirectory => "${basedir}/public",
             :webXml => "${basedir}/public/WEB-INF/web.xml",
             :webappDirectory => "${basedir}/public",
             :hostedWebapp => "${basedir}/public",
             :inplace => true,
             :logLevel => "INFO",
             :treeLogger => true,
             :extraJvmArgs => "-Xmx512m",
             :gen => "${project.build.directory}/generated",
             :runTarget => "Rideboard.html"
           })
  gwt.executions.goals << ["clean", "compile", "test"]
end

profile :development do |p|
  p.activation.by_default
  p.plugin('org.codehaus.mojo:gwt-maven-plugin', '${gwt.version}') do |gwt|
    gwt.with({ :module => 'de.mkristian.ixtlan.rideboards.RideboardDevelopment',
               :style => "DETAILED",
               :includes => "**/RideboardGWTTestSuite.java",
               :draftCompile => true })
  end
end

profile :production do |p|
  p.plugin('org.codehaus.mojo:gwt-maven-plugin', '${gwt.version}') do |gwt|
    gwt.with({ :module => 'de.mkristian.ixtlan.rideboards.Rideboard',
               :style => "OBF",
               :draftCompile => false,
               :disableClassMetadata => true,
               :disableCastChecking => true,
               :optimizationLevel => 9})
  end
end

#-- Macs need the -d32 -XstartOnFirstThread jvm options -->
profile("mac") do |mac|
  mac.activation.os.family "mac"
  mac.plugin('org.codehaus.mojo:gwt-maven-plugin', '${gwt.version}').with(:extraJvmArgs => "-d32 -XstartOnFirstThread -Xmx512m")
end

# lock down versions
properties['gwt.version'] = '2.4.0'
properties['jruby.version'] = '1.7.2'
properties['jruby.plugins.version'] = '0.29.3'
# jetty version to run it in standalone jetty
properties['jetty.version'] = '8.1.9.v20130131'

# vim: syntax=Ruby
