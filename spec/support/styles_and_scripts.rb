module AssetSpecs

  def page_have_script(script)
    find('script')['src'].should eq(javascript_path(script))
  end

  def page_have_style(link)
    find('link')['href'].should eq(stylesheet_path(link))
  end

  def page_have_not_style(link)
    find('link')['href'].should_not eq(stylesheet_path(link))
  end
  
  def page_have_not_script(script)
    find('script')['src'].should_not eq(javascript_path(script))
  end

  def page_have_title(title)
    first('head title').native.text.should eq(title) 
  end
end
