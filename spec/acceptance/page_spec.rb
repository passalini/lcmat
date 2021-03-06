# -*- encoding : utf-8 -*-
require 'spec_helper'

feature 'Manipulate page' do
  background do
    @user = FactoryGirl.create :user, :email => 'user@user.com', :password => '123456'
    FactoryGirl.create :configuration
    login(@user.email,'123456')
  end

  context 'new' do
    before :each do
      visit '/admin/page/new'
    end

    scenario 'successfully' do
      fill_in 'Título', :with => 'Novo título'
      fill_in 'Conteúdo', :with => ''
      check 'Publicado'
      click_button 'Salvar'
      page.should have_content 'Página criado(a) com sucesso.'
    end

    scenario 'failure' do
      fill_in 'Título', :with => ''
      click_button 'Salvar'
      page.should have_content 'Título não pode ser vazio.'
    end
  end

  context 'edit' do
    before :each do
      page = FactoryGirl.create :page
      visit "/admin/page/#{page.id}/edit"
    end

    scenario 'successfully' do
      fill_in 'Título', :with => 'Novo título'
      fill_in 'Conteúdo', :with => ''
      check 'Publicado'
      click_button 'Salvar'
      page.should have_content 'Página atualizado(a) com sucesso.'
    end

    scenario 'failure' do
      fill_in 'Título', :with => ''
      click_button 'Salvar'
      page.should have_content 'Título não pode ser vazio.'
    end
  end

  scenario 'cannot delete contact page' do
    page = FactoryGirl.create :page, indicator: Page::PAGES[:contact]
    lambda {
      visit "/admin/page/#{page.id}/delete"
    }.should raise_error CanCan::AccessDenied
  end

  scenario 'can delete user created pages' do
    page = FactoryGirl.create :page, indicator: nil
    lambda {
      visit "/admin/page/#{page.id}/delete"
    }.should_not raise_error CanCan::AccessDenied
  end
end

