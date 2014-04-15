class SponsorCell < PM::TableViewCell
  attr_reader :sponsor_image

  def initWithStyle(style_name, reuseIdentifier: reuseIdentifier)
    super.tap do
      self.contentView.stylesheet = Teacup::Stylesheet[:sponsor_cell]
      layout(self.contentView, :content_view) do
        @sponsor = subview(UIImageView, :sponsor)
      end
    end
  end

  def sponsor_image=(i)
    @sponsor.image = i
  end
end
