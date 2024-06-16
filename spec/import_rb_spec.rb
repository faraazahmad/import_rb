# frozen_string_literal: true

RSpec.describe ImportRb do
  it "has a version number" do
    expect(ImportRb::VERSION).not_to be nil
  end

  context "Kernel#import" do
    it "imports into the global context" do
      import [:Alpha.as(:Alif), :Beta], from: 'spec/fixtures/sample.rb'

      expect(Alif.new.speak).to eq('alpha hath spoken')
      expect(Beta.new.speak).to eq('beta hath spoken')
      expect { Gamma.new.speak }.to raise_error(NameError)
    end
  end

  context "Class#import" do
    it "imports the constant into the class" do
      class SomeClass; end
      SomeClass.import [:Alpha.as(:Alif), :Beta], from: 'spec/fixtures/sample.rb'

      expect(SomeClass::Alif.new.speak).to eq('alpha hath spoken')
      expect(SomeClass::Beta.new.speak).to eq('beta hath spoken')
      expect { SomeClass::Gamma.new.speak }.to raise_error(NameError)
    end
  end

  context "Module#import" do
    it "imports the constant into the class" do
      module SomeModule; end
      SomeModule.import [:Alpha.as(:Alif), :Beta], from: 'spec/fixtures/sample.rb'

      expect(SomeModule::Alif.new.speak).to eq('alpha hath spoken')
      expect(SomeModule::Beta.new.speak).to eq('beta hath spoken')
      expect { SomeModule::Gamma.new.speak }.to raise_error(NameError)
    end
  end
end
