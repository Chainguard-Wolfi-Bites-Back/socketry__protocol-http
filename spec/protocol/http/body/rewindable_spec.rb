# frozen_string_literal: true

# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'protocol/http/body/rewindable'

RSpec.describe Protocol::HTTP::Body::Rewindable do
	let(:source) {Protocol::HTTP::Body::Buffered.new}
	subject {described_class.new(source)}
	
	it "doesn't get affected by clearing chunks" do
		source.write("Hello World!")
		
		2.times do
			chunk = subject.read
			expect(chunk).to be == "Hello World!"
			chunk.clear
			
			subject.rewind
		end
	end
	
	it "can write and read data" do
		3.times do |i|
			source.write("Hello World #{i}")
			expect(subject.read).to be == "Hello World #{i}"
		end
	end
	
	it "can write and read data multiple times" do
		3.times do |i|
			source.write("Hello World #{i}")
		end
		
		3.times do
			subject.rewind
			
			expect(subject.read).to be == "Hello World 0"
		end
	end
	
	it "can buffer data in order" do
		3.times do |i|
			source.write("Hello World #{i}")
		end
		
		2.times do
			subject.rewind
			
			3.times do |i|
				expect(subject.read).to be == "Hello World #{i}"
			end
		end
	end
	
	describe '#empty?' do
		it {is_expected.to be_empty}
		
		context "with unread chunk" do
			before {source.write("Hello World")}
			it {is_expected.to_not be_empty}
		end
		
		context "with read chunk" do
			before do
				source.write("Hello World")
				expect(subject.read).to be == "Hello World"
			end
			
			it {is_expected.to be_empty}
		end
		
		context "with rewound chunk" do
			before do
				source.write("Hello World")
				expect(subject.read).to be == "Hello World"
				subject.rewind
			end
			
			it {is_expected.to_not be_empty}
		end
		
		context "with rewound chunk" do
			before do
				source.write("Hello World")
				expect(subject.read).to be == "Hello World"
				subject.rewind
				expect(subject.read).to be == "Hello World"
			end
			
			it {is_expected.to be_empty}
		end
	end
end
