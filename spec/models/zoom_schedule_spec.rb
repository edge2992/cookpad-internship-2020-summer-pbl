require 'rails_helper'

RSpec.describe ZoomSchedule, type: :model do
  it 'is valid with text and uuid' do
    zoom = ZoomSchedule.new(
      text: "Kazuya Isawaさんがあなたを予約されたZoomミーティングに招待しています。
      トピック: マイミーティング
      時間: 2020年8月26日 03:00 PM 大阪、札幌、東京
      Zoomミーティングに参加する
      https://us02web.zoom.us/j/84064231812?pwd=SzNFbS9uSjVRQzE5TU5RL0VnOXUyZz
      ミーティングID: 840 6423 1813
      パスコード: n7xEhaa",
      uuid: "1e320343e107de2dd5acf2d760a5beb06983d474"
    )
    expect(zoom).to be_valid
  end

  it "is invalid without text" do
    zoom = ZoomSchedule.new(text: nil)
    zoom.valid?
    expect(zoom.errors[:text]).to include("can't be blank")
  end

  it "is invalid without uuid" do 
    zoom = ZoomSchedule.new(uuid: nil)
    zoom.valid?
    expect(zoom.errors[:uuid]).to include("can't be blank")
  end

end
