module ContentFilters
  ALLOWED_CLASSES = %w[
    twitter-tweet
    instagram-media
    imgur-embed-pub
    kg-bookmark-card
    kg-bookmark-author
    kg-bookmark-container
    kg-bookmark-content
    kg-bookmark-description
    kg-bookmark-icon
    kg-bookmark-metadata
    kg-bookmark-publisher
    kg-bookmark-thumbnail
    kg-bookmark-title
  ]

  # RSSHub marks a body that carries both the official text and its Chinese
  # translation with these two attributes. They are the only data attributes
  # content may keep, and only in the shape that pairs the two sides: the role
  # names one of the two, the paragraph is the position both sides share.
  TRANSLATION_ROLES = %w[source translation].freeze
  TRANSLATION_ELEMENTS_XPATH = "./descendant-or-self::*[@data-news-role]"
  CONTENT_DATA_ATTRIBUTES_XPATH = './/@*[starts-with(name(), "data-")]'

  class Attributes < HTML::Pipeline::Filter
    def call
      elements_with("style").each do |element|
        element.delete("style")
      end
      elements_with("align").each do |element|
        element.delete("align")
      end
      elements_with("class").each do |element|
        classes = (element["class"] || "").split
        classes = classes & ALLOWED_CLASSES
        if classes.empty?
          element.delete("class")
        else
          element["class"] = classes.join(" ")
        end
      end
      # Loofah allows every data-* attribute through without a protocol check,
      # and Feedbin's front end dispatches on them: data-behavior, data-controller
      # and data-iframe-* all reach the app's own handlers. None of them may come
      # from the content, so they go here rather than being allow-listed. The
      # ones Feedbin sets itself are added by filters that run after this one.
      #
      # Selecting the attribute nodes directly keeps the matching in libxml.
      # Walking every element and every attribute from Ruby measured ~6x slower
      # on real entry content and got worse as the document grew.
      translation_markers = collect_translation_markers
      doc.xpath(CONTENT_DATA_ATTRIBUTES_XPATH).each(&:unlink)
      restore_translation_markers(translation_markers)
      doc
    end

    private

    # Pairs of element and role for the markers that pair a translation. A role
    # or paragraph outside the expected shape is content-supplied noise, so it
    # is not read here and the attributes below remove it.
    def collect_translation_markers
      doc.xpath(TRANSLATION_ELEMENTS_XPATH).filter_map do |element|
        role = element["data-news-role"]
        paragraph = element["data-news-paragraph"]
        next unless TRANSLATION_ROLES.include?(role)
        next unless paragraph&.match?(/\A\d+\z/)

        [element, role, paragraph]
      end
    end

    def restore_translation_markers(markers)
      markers.each do |element, role, paragraph|
        element["data-news-role"] = role
        element["data-news-paragraph"] = paragraph
      end
    end
  end
end
