module ApplicationHelper
  def youtube_embed(id)
    %{<iframe width="420" height="315"
      src="https://www.youtube.com/embed/#{html_escape(id)}" frameborder="0"
      allowfullscreen></iframe>}.html_safe
  end
end
