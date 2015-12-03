RSpec.describe Admin::ContestGroupsController, type: :controller do
  context 'without a logged in user' do
    describe 'GET #index' do
      before { get :index }

      it { should redirect_to(new_session_path) }
    end

    # TODO add tests for the other actions
  end

  shared_examples "accessed by an unauthorized user" do
    # TODO add tests for coach and contester
  end

  context 'with an admin user' do

    let(:user) { create(:user, role: User::ADMIN) }

    before { sign_in(user) }

    let(:first_contest_group) { create :contest_group }
    let(:second_contest_group) { create :contest_group }

    context 'routing' do
      it { should route(:get,    '/admin/contest_groups').to        action: :index }
      it { should route(:get,    '/admin/contest_groups/new').to    action: :new }
      it { should route(:post,   '/admin/contest_groups').to        action: :create }
      it { should route(:get,    '/admin/contest_groups/1/edit').to action: :edit, id: 1 }
      it { should route(:put,    '/admin/contest_groups/1').to      action: :update, id: 1}
      it { should route(:delete, '/admin/contest_groups/1').to      action: :destroy, id: 1 }
    end

    it { should use_before_action(:set_contest_group) }

    describe 'GET #index' do
      before { get :index }

      it 'assigns all contest groups as @contest_groups' do
        expect(assigns(:contest_groups)).to eq [first_contest_group, second_contest_group]
      end

      it { should render_template :index }
      it { should respond_with :success }
    end

    describe 'GET #new' do

      before { get :new }

      it 'assigns a new contest group as @contest_group' do
        expect(assigns(:contest_group)).to be_a_new(ContestGroup)
      end

      it { should render_template :new }
      # TODO: resolve error thrown by render_views, required for this test
      # it { should render_template partial: '_form' }
      it { should respond_with :success }
    end

    describe 'GET #edit' do
      before { get :edit, id: first_contest_group.to_param }

      it 'assigns the requested contest group as @contest_group' do
        expect(assigns(:contest_group)).to eq first_contest_group
      end

      it { should render_template :edit }
      # TODO: resolve error thrown by render_views, required for this test
      # it { should render_template partial: '_form' }
      it { should respond_with :success }
    end

    describe 'POST #create' do
      # TODO
      # it do
      #   params = {contest_group: attributes_for(:contest_group)}
      #   should permit(:name).for(:create, params: params)
      # end

      context 'with valid attributes' do
        let(:valid_attributes) { attributes_for :contest_group }
        let(:request) { -> { post :create, contest_group: valid_attributes } }

        before { request.call }

        it 'creates a new contest group' do
          expect(&request).to change(ContestGroup, :count).by 1
        end

        it { should redirect_to action: :index }
        it { should set_flash['notice'].to 'Групата бе създадена успешно.' }
        it { should respond_with :found }
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { attributes_for :contest_group, name: nil }

        before { post :create, contest_group: invalid_attributes }

        it 'assigns a newly created but unsaved contest group as @contest_group' do
          expect(assigns(:contest_group)).to be_a_new ContestGroup
        end

        it { should render_template :new }
        # TODO: resolve error thrown by render_views, required for this test
        # it { should render_template partial: '_form' }
        it { should respond_with :success }
      end
    end

    describe 'GET #update' do
      let(:contest_group) { create :contest_group }

      # TODO
      # it do
      #   params = {contest_group: new_attributes}
      #   should permit(:name).for(:update, params: params)
      # end

      context 'with valid attributes' do
        let(:valid_attributes) { attributes_for :contest_group, name: 'New name' }

        before do
          put :update, id: contest_group.to_param, contest_group: valid_attributes
          contest_group.reload
        end

        it 'updates the requested contest group\'s name' do
          expect(assigns(:contest_group).name).to eq valid_attributes[:name]
        end

        it { should redirect_to action: :index }
        it { should set_flash['notice'].to 'Групата бе обновена успешно.' }
        it { should respond_with :found }
      end

      context 'with invalid attributes' do
        let(:invalid_attributes) { attributes_for :contest_group, name: nil }

        before do
          put :update, id: contest_group.to_param, contest_group: invalid_attributes
          contest_group.reload
        end

        it 'assigns the reqeusted but bot updated contest group as @contest_group' do
          expect(assigns(:contest_group)).to eq contest_group
        end

        it { should render_template :edit }
        it { should respond_with :success }
      end
    end

    describe 'DELETE #destroy' do
      context 'an empty contest group' do
        let!(:contest_group) { create :contest_group }
        let(:request) { -> { delete :destroy, id: contest_group.to_param } }

        it 'destroys the requested contest group' do
          expect(&request).to change(ContestGroup, :count).by -1
        end

        it do
          request.call
          should redirect_to action: :index
        end

        it do
          request.call
          should respond_with :found
        end

        it do
          request.call
          should set_flash['notice'].to 'Групата бе изтрита успешно.'
        end
      end

      context 'a contest group with contests assigned to it' do
        let!(:contest_group) { create :contest_group }
        let(:request) { -> { delete :destroy, id: contest_group.to_param } }
        before { create :contest, contest_group: contest_group }

        it 'doesn\'t destroy the requested contest group' do
          expect(&request).not_to change(ContestGroup, :count)
        end

        it do
          request.call
          should render_template :index
        end

        it do
          request.call
          should respond_with :success
        end

        it do
          request.call
          should set_flash[:error].to 'Групата не е празна. Моля, преместете състезанията в друга група'
        end
      end
    end
  end
end
