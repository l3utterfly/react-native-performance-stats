require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

folly_version = '2021.06.28.00-v2'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name            = "react-native-performance-stats"
  s.version         = package["version"]
  s.summary         = package["description"]
  s.description     = package["description"]
  s.homepage        = package["homepage"]
  s.license         = package["license"]
  s.platforms       = { :ios => "11.0" }
  s.author          = package["author"]
  s.source          = { :git => package["repository"], :tag => "#{s.version}" }

  s.source_files    = "ios/**/*.{h,m,mm,swift}"

  s.dependency "React-Core"

  # This guard prevent to install the dependencies when we run `pod install` in the old architecture.
  if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
        s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
        s.pod_target_xcconfig    = {
            "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
            "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
        }

        s.dependency "React-Codegen"
        s.dependency "RCT-Folly"
        s.dependency "RCTRequired"
        s.dependency "RCTTypeSafety"
        s.dependency "React"
    end
end
