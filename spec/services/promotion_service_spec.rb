# frozen_string_literal: true

RSpec.describe PromotionService do
  let(:order) { create(:order) }
  let(:valid_code) { create(:promotion_code, code: 'ABCDEF1') }

  describe '#apply' do
    context 'with valid code (有効なコードの場合)' do
      it 'applies discount and invalidates code (割引適用と無効化)' do
        service = described_class.new(order, 'ABCDEF1')

        expect { service.apply }
          .to change { order.reload.discount }.to(valid_code.discount_amount)
          .and change { valid_code.reload.used }.to(true)
      end
    end

    context 'with invalid code (無効なコードの場合)' do
      let(:test_cases) do
        [
          { input: 'SHORT', expected: invalid_code },
          { input: 'LONGCODE', expected: :invalid_code },
          { input: 'INVALID', expected: :invalid_code }
        ]
      end

      it 'returns localized error messages (適切なエラーメッセージを返す)' do
        test_cases.each do |tc|
          service = described_class.new(order, tc[:input])
          service.apply
          expect(result[:error]).to eq(I18n.t("promotion_service.errors.#{tc[:expected]}"))
        end
      end
    end
  end
end
