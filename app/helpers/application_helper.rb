module ApplicationHelper
  def flash_classname(type)
    case type
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-error'
    when 'alert' then 'alert alert-warning'
    else 'alert'
    end
  end


  def default_meta_tags
    {
      site: 'にどねんね',
      title: '二度寝防止のためのサービス',
      reverse: true,
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: 'にどねんねは二度寝の防止を手助けするアプリです！ラインと連携することにより指定した時間帯に問題が届きます。このアプリを利用して朝活をより良いものにしていきましょう。',
      keywords: 'にどねんね, 二度寝',   #キーワードを「,」区切りで設定する
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
      ],
      og: {
        site_name: 'にどねんね',
        title: :title,
        description: 'にどねんねは二度寝の防止を手助けするアプリです！ラインと連携することにより指定した時間帯に問題が届きます。このアプリを利用して朝活をより良いものにしていきましょう。', 
        type: 'website',
        url: request.original_url,
        image: image_url('opg.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@8ZlkNVp69e3wOCF',
        image: image_url('opg.png')
      }
    }
  end
end
