Pod::Spec.new do |s|
    s.name         = "CGXCategoryView-OC"    #存储库名称
    s.version      = "1.4.1"      #版本号，与tag值一致
    s.summary      = "CGXCategoryView-OC是仿今日头条、爱奇艺、腾讯视频、优酷等主流APP分类切换滚动视图的库)"  #简介
    s.description  = "( 今日头条、拼多多、QQ音乐、京东、爱奇艺、腾讯视频、优酷、淘宝、天猫、简书、微博等主流APP分类切换滚动视图)  封装"  #描述
    s.homepage     = "https://github.com/974794055/CGXCategoryView-OC"      #项目主页，不是git地址
    s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
    s.author             = { "974794055" => "974794055@qq.com" }  #作者
    s.platform     = :ios, "8.0"                  #支持的平台和版本号
    s.source       = { :git => "https://github.com/974794055/CGXCategoryView-OC.git", :tag => s.version }         #存储库的git地址，以及tag值
    s.requires_arc = true #是否支持ARC
    s.frameworks = 'UIKit'
    #需要托管的源代码路径
    s.source_files = 'CGXCategoryViewOC/CGXCategoryView.h'
    #开源库头文件
    s.public_header_files = 'CGXCategoryViewOC/CGXCategoryView.h'
    
    s.subspec 'Common' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Common/**/*.{h,m}'
    end
    
    s.subspec 'ListContainer' do |ss|
        ss.source_files = 'CGXCategoryViewOC/ListContainer/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
    end
    
    s.subspec 'Base' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Base/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/ListContainer'
    end
    
    s.subspec 'IndicatorViews' do |ss|
        ss.source_files = 'CGXCategoryViewOC/IndicatorViews/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
    end
    
    s.subspec 'Indicator' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Indicator/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
    end
    
    
    s.subspec 'Title' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Title/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
    end
    
    
    
    s.subspec 'Dot' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Dot/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
    end
    
    
    s.subspec 'Image' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Image/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
    end
    
    s.subspec 'TitleImage' do |ss|
        ss.source_files = 'CGXCategoryViewOC/TitleImage/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
    end
    
    s.subspec 'Badge' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Badge/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/TitleImage'
    end
    
    s.subspec 'TitleAttribute' do |ss|
        ss.source_files = 'CGXCategoryViewOC/TitleAttribute/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
    end
    
    s.subspec 'VerticalZoomTitle' do |ss|
        ss.source_files = 'CGXCategoryViewOC/VerticalZoomTitle/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
    end
    
    s.subspec 'TitleSortView' do |ss|
        ss.source_files = 'CGXCategoryViewOC/TitleSortView/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
    end
    
    
    s.subspec 'TitleSubtitleView' do |ss|
        ss.source_files = 'CGXCategoryViewOC/TitleSubtitleView/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
    end
    
    s.subspec 'MenuView' do |ss|
        
        ss.source_files = 'CGXCategoryViewOC/MenuView/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
        ss.dependency 'CGXCategoryView-OC/IndicatorViews'
        ss.dependency 'CGXCategoryView-OC/Indicator'
        ss.dependency 'CGXCategoryView-OC/Title'
        ss.dependency 'CGXCategoryView-OC/TitleImage'
    end
    
    s.subspec 'Segmented' do |ss|
        ss.source_files = 'CGXCategoryViewOC/Segmented/**/*.{h,m}'
        ss.dependency 'CGXCategoryView-OC/Common'
        ss.dependency 'CGXCategoryView-OC/Base'
    end
    
    
    
    
end




