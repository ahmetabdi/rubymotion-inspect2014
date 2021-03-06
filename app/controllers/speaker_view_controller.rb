class SpeakerViewController < PM::Screen
  attr_accessor :speaker
  stylesheet :speaker
  title 'Speaker'

  layout :root do
    @scroll = subview(UIScrollView, :scroll) do
      @content = subview(UIView, :content) do
        @speaker_image = subview(CachedImage, :speaker_image)
        @speaker_name = subview(UILabel, :speaker_name)

        @speaker_company_line = subview(UIView, :line)
        @speaker_company = subview(UILabel, :speaker_company)

        @speaker_bio = subview(UILabel, :speaker_bio)

        @speaker_twitter = subview(UIButton.custom, :twitter)
        @speaker_www = subview(UIButton.custom, :www)
        subview(UIView, :padding)
      end
    end
  end

  def will_appear
    s = speaker_properties
    ap s if BW.debug?
    @speaker_image.placeholder = 'speaker_placeholder'
    @speaker_image.set_image s['speaker_image']
    @speaker_name.text = s['name']
    @speaker_company.text = " #{s['company']}  "
    @speaker_bio.text = s['description']

    @speaker_twitter.on(:touch) do
      "https://twitter.com/#{s['twitter']}".nsurl.open
    end

    @speaker_www.on(:touch) do
      s['www'].nsurl.open
    end
  end

  def on_appear
    @scroll.contentSize = CGSizeMake(Device.screen.width, @content.totalHeight)
  end

  def speaker_properties
    all = SpeakerData.sharedSpeakers.all
    return if @speaker < 0 || @speaker >= all.length
    all[@speaker]
  end
end
