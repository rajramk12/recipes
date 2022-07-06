require 'test_helper'
class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname:"User",email:"vk@superuser.com")
  end

  test "Chef details should be valid " do
    assert @chef.valid?
  end

  test "mandatory chef name " do  
    @chef.chefname =""
    assert_not @chef.valid?
  end 

  test "chef name length 30 char" do
    @chef.chefname = "a"*31
    assert_not @chef.valid?
    end

    test "mail id is must" do
        @chef.email =""
        assert_not @chef.valid?
      end

      test "mail id can't be too long" do
        @chef.email = "a" * 250 + "@example.com"
        assert_not @chef.valid?
    end 


    test "email should be uniq and case insensitive" do
        duplicate_chef = @chef.dup
        duplicate_chef.email = @chef.email.upcase
        @chef.save
        assert_not  duplicate_chef.valid?
      end


      test "email should accept correct format" do
        valid_emails = %w[user@example.com MASHRUR@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
        valid_emails.each do |valids|
          @chef.email = valids
          assert @chef.valid?, "#{valids.inspect} should be valid"
        end
      end
      
      test "should reject invalid addresses" do
        invalid_emails = %w[mashrur@example mashrur@example,com mashrur.name@gmail. joe@bar+foo.com]
        invalid_emails.each do |invalids|
          @chef.email = invalids
          assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
        end
      end 

test "emails to be in lower case before saving to DB" do
  mail = "JOMqwe@yahOo.cOM"
  @chef.email = mail
  @chef.save
  assert_equal mail.downcase, @chef.reload.email
end 


end 