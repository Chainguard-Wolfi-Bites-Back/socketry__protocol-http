# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# Copyright, 2013, by Ilya Grigorik.
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

module HTTP
	module Protocol
		class Error < StandardError
		end

		# Raised if connection header is missing or invalid indicating that
		# this is an invalid HTTP 2.0 request - no frames are emitted and the
		# connection must be aborted.
		class HandshakeError < Error
		end

		# Raised by stream or connection handlers, results in GOAWAY frame
		# which signals termination of the current connection. You *cannot*
		# recover from this exception, or any exceptions subclassed from it.
		class ProtocolError < Error
		end

		# Raised on invalid flow control frame or command.
		#
		# @see ProtocolError
		class FlowControlError < ProtocolError
		end

		# Raised on invalid stream processing: invalid frame type received or
		# sent, or invalid command issued.
		class InternalError < ProtocolError
		end

		#
		# -- Recoverable errors -------------------------------------------------
		#

		# Raised if stream has been closed and new frames cannot be sent.
		class StreamClosed < Error
		end

		# Raised if connection has been closed (or draining) and new stream
		# cannot be opened.
		class ConnectionClosed < Error
		end

		# Raised if stream limit has been reached and new stream cannot be opened.
		class StreamLimitExceeded < Error
		end
	end
end
