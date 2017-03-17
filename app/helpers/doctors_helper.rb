module DoctorsHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(doctor, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(doctor.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: doctor.name, class: "gravatar")
  end
end
