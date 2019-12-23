module ControllersSpecHelper
  def expect_success
    expect(status).to eq(200), "expected HTTP/200 but was #{response.status}"
  end

  def expect_success_verbose
    expect(status).to eq(200), "expected HTTP/200 but was #{response.status}, response body: #{response.body}"
  end

  def expect_redirect
    expect(status).to eq(302), "expected HTTP/302 from #{response.inspect}"
  end

  def expect_bad_request
    expect(status).to eq(400), "expected HTTP/400 from #{response.inspect}"
  end

  def expect_server_error
    expect(status).to eq(500), "expected HTTP/500 from #{response.inspect}"
  end

  def expect_resource_not_found
    expect(status).to eq(404), "expected HTTP/404 from #{response.status}"
  end

  def expect_redirect_to(path)
    expect(response).to redirect_to(path),
      "expected redirect to #{path} but got \
#{response && response.status} --> #{response && response.location}"
  end

  def expect_blocked
    expect_redirect_to(root_path)
    expect(flash[:error]).to include('You are not authorized to access this page.')
  end

  def expect_flash_alert(str)
    expect(response.body).to match(str)
  end

  def expect_sign_in
    expect(response).to redirect_to(new_user_session_path)
  end

  def user_signed_in
    warden.authenticated?(:user)
  end

  def set_referer(r)
    request.env['HTTP_REFERER'] = r
  end

end
