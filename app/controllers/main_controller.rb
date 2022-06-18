class MainController < ApplicationController
  def index

  end

  def shorten
    target = params[:url]

    if target =~ /^https?:\/\//
      Logger.info 'URL is formatted correctly'
    else
      target = "https://#{target}"
    end

    if ShortUrl.exists?(target_url: target)
      short_link = ShortUrl.find_by(target_url: target).shortened_url
    else
      short_link = ShortUrl.create(target_url: target, shortened_url: SecureRandom.urlsafe_base64(3))
    end

    $tiny_url = ShortUrl.find_by(target_url: target).shortened_url
    redirect_to result_path
  end

  def redirect
    short_url = params[:short_url]
    target = ShortUrl.find_by(shortened_url: short_url)
    redirect_to target.target_url, allow_other_host: true
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

