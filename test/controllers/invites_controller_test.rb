require 'test_helper'

describe InvitesController do
  let(:user) { accounts(:user) }
  let(:invite) { build(:invite) }

  it 'new invite requires login' do
    get :new, contributor_id: invite.contribution.id
    must_respond_with :unauthorized
  end

  it 'new invite render the form' do
    login_as user
    get :new, contributor_id: invite.contribution.id
    must_respond_with :success
  end

  it 'should create the invite' do
    login_as user
    assert_difference('Invite.count', 1) do
      post :create, contributor_id: invite.contribution.id, invite: { invitee_email: 'abc@yahoo.com' }
    end
    assigns(:invite).success_flash.must_equal I18n.t('invites.thank_you_message', name: assigns(:invite).name.name,
                                                                                  email: 'abc@yahoo.com')
    must_respond_with :redirect
  end

  it 'shouldn\'t create a duplicate invite' do
    login_as user
    post :create, contributor_id: invite.contribution.id, invite: { invitee_email: 'abc@yahoo.com' }
    assert_no_difference('Invite.count') do
      post :create, contributor_id: invite.contribution.id, invite: { invitee_email: 'abc@yahoo.com' }
    end
  end
end