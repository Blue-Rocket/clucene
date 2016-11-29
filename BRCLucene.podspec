Pod::Spec.new do |s|

  s.name         = "BRCLucene"
  s.version      = "1.0.0"
  s.summary      = "CLucene as a Pod"
  s.description  = <<-DESC
                   This project provides provides a pod for the
                   [CLucene](http://clucene.sourceforge.net/) search framework.
                   DESC

  s.homepage     = "https://github.com/Blue-Rocket/clucene"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "Matt Magoffin" => "matt@bluerocket.us" }

  s.ios.deployment_target = '5.1'
  s.osx.deployment_target = '10.7'

  s.source       = { :git => "https://github.com/Blue-Rocket/clucene.git",
  					 :tag => s.version.to_s, :submodules => true }

  s.libraries		= 'c++', 'z'
  s.compiler_flags	= '-Wmost',
  					  '-fvisibility=default', '-fPIC', '-D_UCS2', '-D_UNICODE', '-D_REENTRANT',
  					  '-DNDEBUG'

  s.xcconfig		= {
  						'GCC_PREPROCESSOR_DEFINITIONS' => '_WCHAR_H_CPLUSPLUS_98_CONFORMANCE_',
  					  }

  s.requires_arc = false

  s.default_subspec = 'CLucene'

  s.subspec 'CLucene' do |as|
  	as.dependency 'BRCLucene/CLucene-Shared'
 	as.dependency 'BRCLucene/CLucene-Core'
 	as.dependency 'BRCLucene/CLucene-Contribs-Lib'
  end

  s.subspec 'CLucene-Config' do |as|
  	as.requires_arc = false
  	as.source_files = "BRCLucene/src/CLucene/*"
  	as.header_mappings_dir = 'BRCLucene/src'
  end

  s.subspec 'CLucene-Core-API' do |as|
  	as.requires_arc = false
  	as.source_files = "src/core/CLucene.h",
  	                  "src/core/CLucene/**/*.h"
  	as.header_mappings_dir = 'src/core'
  	as.exclude_files = "src/core/CLucene/CLMonolithic.*",
						"src/core/CLucene/search/FilterResultCache.*",
						"src/core/CLucene/queryParser/legacy"
    as.dependency 'BRCLucene/CLucene-Config'
  end

  s.subspec 'CLucene-Shared' do |as|
  	as.requires_arc = false
  	as.source_files = "src/shared/CLucene/**/*.{h,c,cpp}"
  	as.header_mappings_dir = 'src/shared'
  	as.exclude_files = "src/shared/CLucene/CLSharedMonolithic.*",
                    	"src/shared/CLucene/util/deflate.*"
    as.dependency 'BRCLucene/CLucene-Core-API'
  end

  s.subspec 'CLucene-Core' do |as|
  	as.requires_arc = false
  	as.source_files = "src/core/CLucene/**/*.{c,cpp}"
  	as.header_mappings_dir = 'src/core'
  	as.exclude_files = "src/core/CLucene/CLMonolithic.*",
  						"src/core/CLucene/search/FilterResultCache.*",
  						"src/core/CLucene/queryParser/legacy"
    as.dependency 'BRCLucene/CLucene-Core-API'
    as.dependency 'BRCLucene/CLucene-Shared'
  end

  s.subspec 'CLucene-Contribs-Lib' do |as|
  	as.requires_arc = false
  	as.source_files = "src/contribs-lib/CLucene/**/*.{h,c,cpp}"
  	as.header_mappings_dir = 'src/contribs-lib'
    as.dependency 'BRCLucene/CLucene-Core'
    as.dependency 'BRCLucene/CLucene-Shared'
  end

end
