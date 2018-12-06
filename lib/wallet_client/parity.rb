# encoding: UTF-8
# frozen_string_literal: true

module WalletClient
  class Parity < Ethereum
    def permit_transaction(issuer, recipient)
      json_rpc(:personal_unlockAccount, [normalize_address(issuer.fetch(:address)), issuer.fetch(:secret), '0x5']).tap do |response|
        unless response['result']
          raise WalletClient::Error, \
            "#{wallet.name} withdrawal from #{normalize_address(issuer[:address])} to #{normalize_address(recipient[:address])} is not permitted."
        end
      end
    end
  end
end
