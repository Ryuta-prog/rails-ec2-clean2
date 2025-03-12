# frozen_string_literal: true

it 'has the correct subject' do
  expect(mail.subject).to eq(I18n.t('mailers.order.confirmation'))
end
