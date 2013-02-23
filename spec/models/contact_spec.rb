require 'spec_helper'

describe Contact do
  let!(:user) { FactoryGirl.create(:user) }

  context "#user" do
    subject { FactoryGirl.build(:contact, phone: "90 533 5554433") }

    it { should belong_to(:user) }
    it { should validate_presence_of(:user) }
  end

  context "#name" do
    subject { FactoryGirl.build(:contact, last_name: "Ibadallah", phone: "+90 333 3432432") }
  
    it { should validate_presence_of(:name) }
    it { should allow_value("Boris").for(:name) }
    it { should allow_value("Niyazullahmetcan").for(:name) }
    it { should_not allow_value("sdf23msfj").for(:name) }
    it { should_not allow_value("sdf^%&)(!").for(:name) }
    it { should_not allow_value("<name>ahmet</name>").for(:name) }
    it { should_not allow_value("sdf sdf sdf").for(:name) }
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(50) }
  end

  context "#last_name" do
    subject { FactoryGirl.build(:contact, name: "Fitrat", phone: "+90 333 3432432") }
  
    it { should allow_value("CarsiPazarOgullari").for(:last_name) }
    it { should allow_value("Dingilli").for(:last_name) }
    it { should allow_value("O'conner").for(:last_name) }
    it { should_not allow_value("sdfjk34fsdf").for(:last_name) }
    it { should_not allow_value("sdffgd^%&)(!").for(:last_name) }
    it { should_not allow_value("<lastName>ahmet</lastName>").for(:last_name) }
    it { should_not allow_value("sdf sdf").for(:last_name) }
    it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(50) }

  end

  context "#phone" do
    subject { FactoryGirl.build(:contact, name: "Fitrat", last_name: "Ibadallah") }
    
    it { should validate_presence_of(:phone) }
    it { should allow_value("905335554433").for(:phone) }
    it { should allow_value("90 533 5554433").for(:phone) }
    it { should allow_value("90 533 555 44 33").for(:phone) }
    it { should allow_value("90 533 555 4433").for(:phone) }
    it { should allow_value("+90 533 5554433").for(:phone) }
    it { should allow_value("+(90) 533 5554433").for(:phone) }
    it { should allow_value("+(90) 533 555 4433").for(:phone) }
    it { should allow_value("+90533 5554433").for(:phone) }
    it { should allow_value("533 5554433").for(:phone) }
    it { should allow_value("533 555 4433").for(:phone) }
    it { should allow_value("533 555 44 33").for(:phone) }
    it { should allow_value("0 533 5554433").for(:phone) }
    it { should allow_value("0 533 555 44 33").for(:phone) }
    it { should allow_value("0533 5554433").for(:phone) }

    it { should_not allow_value("<phone>90 444 3331122").for(:phone) }
    it { should_not allow_value("<phone>90 444 3331122</phone>").for(:phone) }
    it { should_not allow_value("sd 533 s44n4c3").for(:phone) }
    it { should_not allow_value("/90533 44433-&").for(:phone) }

    context "diiferent lengths" do
      it "like 90 53* 444****" do
        subject.phone = "90 53* 444****"
        should_not be_valid 
      end

      it "like 533 555223" do
        subject.phone = "553 555223"
        should_not be_valid 
      end

      it "like 90 53* 444****" do
        subject.phone = "90 53* 444****"
        should_not be_valid 
      end

      it "like 90 533 555223300" do
        subject.phone = "990 533 55522330"
        should_not be_valid 
      end
      
    end

    it { should ensure_length_of(:phone).is_at_least(10).is_at_most(19)}
    
    context "#cleaning_up" do
      let(:user) { FactoryGirl.create(:user) }

      it "is called before save" do
        contact = Contact.new(name: "Fitrat", last_name: 'Ibadallah', phone: '+(90) 533 555 4433') 
        contact.user = user
        contact.should_receive(:clean_up_phone)
        contact.save!
      end
    end
  end
end
