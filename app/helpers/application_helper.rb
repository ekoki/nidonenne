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
      title: 'にどねんね',
      reverse: true,
      separator: '|',   #Webサイト名とページタイトルを区切るために使用されるテキスト
      description: 'にどねんねは二度寝を防止の防止を手助けするアプリです！',
      keywords: 'にどねんね, 二度寝',   #キーワードを「,」区切りで設定する
      canonical: 'https://www.nidonenne.com',
      noindex: ! Rails.env.production?,
      og: {
        site_name: 'にどねんね',
        title: '二度寝を防止しよう！',
        description: '二度寝を防止するアプリです', 
        type: 'website',
        url: 'https://www.nidonenne.com',
        image: image_url('opg.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@ツイッターのアカウント名',
        image: image_url('opg.png')
      }
    }
  end











end
