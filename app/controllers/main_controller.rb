class MainController < ApplicationController
  def index

  end

  def shorten
    target = params[:url ]

    if target =~ /^https?:\/\//
      logger.debug '[LOGGER] URL is formatted correctly'
    else
      target = "https://#{target}"
      logger.info "[LOGGER] URL is not formatted correctly, adding https://"
    end

    if ShortUrl.exists?(target_url: target)
      short_link = ShortUrl.find_by(target_url: target).shortened_url
      logger.info "[LOGGER] URL already exists, exiting with #{short_link}"
    else
      new_short_link = ShortUrl.create(target_url: target, shortened_url: SecureRandom.urlsafe_base64(3), clicks: 0)
      logger.info "[LOGGER] URL does not exist, creating new short link #{new_short_link.shortened_url}"
    end

    $tiny_url = ShortUrl.find_by(target_url: target).shortened_url
    redirect_to result_path
  end

  def redirect
    short_url = params[:short_url]
    if target = ShortUrl.find_by(shortened_url: short_url)
      target.clicks += 1
      target.save
      redirect_to target.target_url, allow_other_host: true
    else
      logger.warn "Attempt to redirect to non-existent short URL #{short_url}"
      redirect_to root_path, notice: 'Invalid URL'
    end
  end

  def lookup
  end

  def result
  end

  def urls
    if ShortUrl.first.nil?
      redirect_to root_path, notice: 'No URLs have been shortened yet'
    end
  end


end

