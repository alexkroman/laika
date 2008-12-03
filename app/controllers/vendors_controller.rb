class VendorsController < ApplicationController
  def create
    vendor = Vendor.new(params[:vendor])
    vendor.user = current_user
    if vendor.save
      flash[:notice] = "Vendor inspection ID was successfully created."
    else
      flash[:notice] = "Failed to create a new vendor inspection ID: #{vendor.errors.full_messages.join(', ')}."
    end
    redirect_to users_url
  end

  def update
    vendor = Vendor.find(params[:id])
    if not vendor.editable_by? current_user
      flash[:notice] = 'You are not permitted to rename this vendor inspection ID.'
    elsif vendor.update_attributes(params[:vendor])
      flash[:notice] = 'Vendor inspection ID was successfully updated.'
    else
      flash[:notice] = "Failed to rename vendor inspection ID: #{vendor.errors.full_messages.join(', ')}."
    end
    redirect_to users_url
  end

  def destroy
    vendor = Vendor.find(params[:id])
    if vendor.editable_by? current_user
      vendor.destroy
      flash[:notice] = "The vendor inspection ID has been deleted."
    else
      flash[:notice] = "You cannot delete this vendor inspection ID."
    end
    redirect_to users_url
  end
end
