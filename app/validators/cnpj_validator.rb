class CnpjValidator < ActiveModel::EachValidator
    class InvalidCNPJ < StandardError; end
  
    EXPECTED_FORMAT = /^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$/
  
    FIRST_CHECKER_DIGITS_MULTIPLIERS = [5,4,3,2,9,8,7,6,5,4,3,2].freeze
    SECOND_CHECKER_DIGITS_MULTIPLIERS = [6,5,4,3,2,9,8,7,6,5,4,3,2].freeze
  
    def validate_each(record, attribute, value)
      return if value.blank?
      return if cnpj_valid?(value)
  
      record.errors.add(
        attribute,
        :invalid_cnpj,
        message: options[:message] || 'is not valid',
        value: value
      )
    end
  
    private
  
    def cnpj_valid?(cnpj)
        @value = cnpj.gsub(/[^\d]/, '')
        @value.match?(/^\d{14}$/) && valid_digits?
    end
  
    def valid_digits?
        number = @value[0..11]
        check = @value[12..13]
        first_checker_digit = discover_checker_digit(number, FIRST_CHECKER_DIGITS_MULTIPLIERS)
        number += first_checker_digit.to_s
        second_checker_digit = discover_checker_digit(number, SECOND_CHECKER_DIGITS_MULTIPLIERS)
        calculated_check = "#{first_checker_digit}#{second_checker_digit}"
        puts "Expected check: #{check}, calculated check: #{calculated_check}"
        check == calculated_check
    end
  
    def discover_checker_digit(number, digits_multipliers)
        sum = 0
        number.split('').each_with_index do |num, index|
          sum += num.to_i * digits_multipliers[index]
        end
        remainder = sum % 11
        remainder < 2 ? 0 : 11 - remainder
    end
  end