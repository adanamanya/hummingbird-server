# rubocop:disable Metrics/LineLength
# == Schema Information
#
# Table name: media_follows
#
#  id         :integer          not null, primary key
#  media_type :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  media_id   :integer          not null
#  user_id    :integer          not null
#
# Foreign Keys
#
#  fk_rails_4407210d20  (user_id => users.id)
#
# rubocop:enable Metrics/LineLength

require 'rails_helper'

RSpec.describe MediaFollow, type: :model do
  let(:timeline) { double(:feed).as_null_object }

  before do
    allow(subject.user).to receive(:timeline).and_return(timeline)
  end

  subject { build(:media_follow) }

  it { should belong_to(:user).touch(true) }
  it { should validate_presence_of(:user) }
  it { should belong_to(:media) }
  it { should validate_presence_of(:media) }

  it 'should follow the media feed on save' do
    expect(subject.user.timeline).to receive(:follow)
      .with(subject.media.feed)
    subject.save!
  end
end
