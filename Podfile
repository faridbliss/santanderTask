platform :ios, '10.3'
use_frameworks!

def ui_pods
  pod 'MaterialComponents', '~> 116.0'
  pod 'RxCocoa'
  pod 'RxKeyboard'
  pod 'RxDataSources'
  pod 'RxSwift'
  pod 'SnapKit'
  pod 'PMJSON', '~> 3.0'
  pod 'Moya/RxSwift'
  pod 'IQKeyboardManagerSwift'
  pod 'ReachabilitySwift'
end

target 'API' do
   ui_pods
end

target 'AppConstants' do
 ui_pods
end

target 'AppStart' do
 ui_pods
end

target 'Base' do
 ui_pods
end

target 'DevTools' do
 ui_pods
end


target 'Resources' do
   pod 'R.swift.Library'
   ui_pods
end

target 'SantanderTask' do
   ui_pods
  target 'SantanderTaskTests' do
    inherit! :search_paths
    # Pods for testing
  end
  target 'SantanderTaskUITests' do
    # Pods for testing
  end
end

target 'UIComponents' do
  pod 'Kingfisher', '~> 5.0'
  ui_pods
end
