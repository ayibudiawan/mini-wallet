class Api::V1::CustomersController < ApiController
  skip_before_action :authenticate_request!

  def init
    return render_json(400, "Params customer_xid is required") if params[:customer_xid].blank?
    customer = Customer.find_by_xid(params[:customer_xid])
    if customer.blank?
      render_json(404, "Customer with xid #{params[:customer_xid]} is not found")
    else
      render json: { data: { token: customer.encode }, status: "success" }, status: :ok
    end
  end
end
