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

require 'protocol/http/middleware'
require 'protocol/http/middleware/builder'

RSpec.describe Protocol::HTTP::Middleware::Builder do
	it "can make an app" do
		app = Protocol::HTTP::Middleware.build do
			run Protocol::HTTP::Middleware::HelloWorld
		end
		
		expect(app).to be Protocol::HTTP::Middleware::HelloWorld
	end
	
	it "defaults to not found" do
		app = Protocol::HTTP::Middleware.build do
		end
		
		expect(app).to be Protocol::HTTP::Middleware::NotFound
	end
	
	it "can instantiate middleware" do
		app = Protocol::HTTP::Middleware.build do
			use Protocol::HTTP::Middleware
		end
		
		expect(app).to be_kind_of Protocol::HTTP::Middleware
	end
end
