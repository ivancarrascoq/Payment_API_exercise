class LoansController < ActionController::API 

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  # show all performed payments
  def index
    all_pmts = []
    Payment.all.each do |p|
      balance = Loan.first.funded_amount - Payment.all.where("id <= ?",p.id).sum(:amount)
      all_pmts.push({id: p.id, payment: p.amount, balance: balance, date: p.created_at})
    end
    render json: all_pmts.to_json
  end

  # show outstanding balance and total payments
  def show
    if Loan.find(params[:id])
      start_loan = Loan.find(params[:id]).funded_amount
      bal = start_loan - Payment.sum(:amount)
      total = Payment.count

      render json: {starting_loan_amount: start_loan ,outstanding_balance: bal, total_pmts: total }.to_json
    else
      render json: {status: 'error'}
    end
  end

  # make a payment
  def create
    if params[:amount].to_d > 0
      var_amount = params[:amount].to_d
      total_pmts = Payment.sum(:amount)
      if var_amount <= (Loan.first.funded_amount - total_pmts)
        Payment.create(amount: var_amount)
        render json: {status: 'success'}
      else
        render json: {status: 'error', message: 'the amount exceed the maximum'}
      end
    else
      render json: {status: 'error', message: 'not valid entry for amount'}
    end
  end
end
