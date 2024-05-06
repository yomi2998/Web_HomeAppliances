<!DOCTYPE html>
<html>

    <head>
        <title>Product - nelson</title>
        <link rel="stylesheet" href="src/css/productmgmt.css">
        <link rel="shortcut icon" href="src/img/favicon.png">
        <%
            //CONFIGURATION

            final boolean ALLOW_ADMIN = true;
            final boolean ALLOW_STAFF = true;
            final boolean ALLOW_CUSTOMER = false;
            final boolean ALLOW_GUEST = false;

            //END OF CONFIGURATION
        %>
    </head>

    <body>
        <div class="nelson-greeter">
            <p style="font-size: 10vw;">Product</p>
        </div>
        <%@ include file="navigation.jsp" %>
        <div class="container" style="display: none;">
            <% String searchStr = request.getParameter("search");
            List<Product> products = searchStr == null || searchStr.equals("") ?  : pc.searchProducts(searchStr, 0); %>
            <div>
                <h1>Product</h1>
                <p class="tab focus" id="view-tab">View</p>
                <p class="tab" id="add-tab">Add</p>
            </div>
            <div id="product-tab">
                <form>
                    <input autocomplete="off" type="text" name="search" class="nelson-input-ii" placeholder="Search products...">
                    <button type="submit" class="nelson-button">Search</button>
                    <button class="nelson-button" onclick="window.location.reload()">Refresh</button>
                </form>
                <table class="nelson-table-ii">
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Available</th>
                        <th>Sold</th>
                        <th>Date created</th>
                        <th>Action</th>
                    </tr>
                    <% for (Product product : products) { %>

                    <tr id="prod-<%= product.getId() %>">
                        <td id="prodDisp"><img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="height: 100px;"></td>
                        <td id="prodName"><%= product.getName() %></td>
                        <td id="prodPrice">RM <%= String.format("%.2f", product.getPrice()) %></td>
                        <td id="prodStock"><%= product.getStock() %></td>
                        <td><%= product.getSold() %></td>
                        <td id="ProdDate"><%= product.getCreate_date() %></td>
                        <td hidden id="prodDesc"><%= product.getDescription() %></td>
                        <td hidden id="prodCat"><%= product.getCategory_id() %></td>
                        <td hidden id="prodSubImg">
                            <% for (String sub : product.getSub_images()) { %>
                            <img src="<%= sub %>" alt="<%= product.getName() %>" style="height: 100px;">
                            <% } %>
                        </td>
                        <td>
                            <button class="nelson-button edit-prod" id="prod-edit-<%= product.getId() %>">Edit</button>
                            <button class="nelson-button delete-prod" id="prod-delete-<%= product.getId() %>">Delete</button>
                        </td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <div id="add-product-tab" hidden>
                <form method="post" id="addProductForm">
                    <div class="input-field">
                        <label for="name" class="label-with-margin">Name:</label><br>
                        <input autocomplete="off" type="text" name="name" placeholder="Name" class="nelson-input" required><br>
                        <p id="product-invalid-name" class="hidden" style="color:red;">Invalid name.</p>
                    </div>
                    <div class="input-field">
                        <label for="price" class="label-with-margin">Price (RM):</label><br>
                        <input autocomplete="off" name="price" placeholder="Price" class="nelson-input" min="0" value="10.00" pattern="^\d*(\.\d{0,2})?$" required><br>
                        <p id="product-invalid-price" class="hidden" style="color:red;">Invalid price.</p>
                    </div>
                    <div class="input-field">
                        <label for="stock" class="label-with-margin">Stock:</label><br>
                        <input autocomplete="off" type="number" name="stock" placeholder="Stock" class="nelson-input" min="0" required><br>
                        <p id="product-invalid-stock" class="hidden" style="color:red;">Invalid stock.</p>
                    </div>
                    <div class="input-field">
                        <label for="description" class="label-with-margin">Description:</label><br>
                        <textarea autocomplete="off" name="description" placeholder="Description" class="big-nelson-input" rows="10" required></textarea>
                        <p id="product-invalid-description" class="hidden" style="color:red;">Invalid description.</p>
                    </div>
                    <div class="input-field">
                        <label for="category" class="label-with-margin">Category:</label><br>
                        <div>
                            <select name="category_id" class="nelson-select" id="option-category" required>
                                <option value="" disabled selected>Select category</option>
                                <% for (Category category : categories) { %>
                                <option value="<%= category.getId() %>"><%= category.getName() %></option>
                                <% } %>
                            </select>
                            <a href="#" onclick="extension_toggle('manage-category-extension')"><button class="nelson-button">Manage</button></a>
                            <a href="#" id="prod-category-refresh"><button class="nelson-button">Refresh</button></a>
                        </div>
                        <p id="invalid-category" class="hidden" style="color:red;">Invalid category.</p>
                    </div>
                    <div class="input-field">
                        <label for="sub_images" class="label-with-margin">Images:</label><br>
                        <input id="add-product-images" autocomplete="off" type="file" name="sub_images" class="nelson-input" accept="image/png, image/jpg, image/jpeg, image/webp" required multiple><br>
                        <p id="product-invalid-image" class="hidden" style="color:red;">Invalid image.</p>
                        <div id="images-preview">
                        </div>
                    </div>
                    <div class="input-field">
                        <label for="display_image" class="label-with-margin">Display Image:</label><br>
                        <input id="add-display-image" autocomplete="off" type="file" name="display_image" class="nelson-input" accept="image/png, image/jpg, image/jpeg, image/webp" required><br>
                        <p id="product-invalid-display_image" class="hidden" style="color:red;">Invalid display image.</p>
                        <div id="display-image-preview">
                        </div>
                    </div>
                    <hr>
                    <div class="buttons-field">
                        <button class="nelson-button" type="reset" id="add-product-reset">Reset</button>
                        <input type="submit" class="nelson-button" value="Add">
                    </div>
                </form>
            </div>
            <div id="edit-product-tab" hidden>
                <form method="post" id="editProductForm">
                    <input type="text" name="id" id="alter-product-id" hidden>
                    <div class="input-field">
                        <label for="name" class="label-with-margin">Name:</label><br>
                        <input id="edit-product-name" autocomplete="off" type="text" name="name" placeholder="Name" class="nelson-input" required><br>
                        <p id="edit-product-invalid-name" class="hidden" style="color:red;">Invalid name.</p>
                    </div>
                    <div class="input-field">
                        <label for="price" class="label-with-margin">Price (RM):</label><br>
                        <input id="edit-product-price" autocomplete="off" name="price" placeholder="Price" class="nelson-input" min="0" value="10.00" pattern="^\d*(\.\d{0,2})?$" required><br>
                        <p id="edit-product-invalid-price" class="hidden" style="color:red;">Invalid price.</p>
                    </div>
                    <div class="input-field">
                        <label for="stock" class="label-with-margin">Stock:</label><br>
                        <input id="edit-product-stock" autocomplete="off" type="number" name="stock" placeholder="Stock" class="nelson-input" min="0" required><br>
                        <p id="edit-product-invalid-stock" class="hidden" style="color:red;">Invalid stock.</p>
                    </div>
                    <div class="input-field">
                        <label for="description" class="label-with-margin">Description:</label><br>
                        <textarea id="edit-product-description" autocomplete="off" name="description" placeholder="Description" class="big-nelson-input" rows="10" required></textarea>
                        <p id="edit-product-invalid-description" class="hidden" style="color:red;">Invalid description.</p>
                    </div>
                    <div class="input-field">
                        <label for="category" class="label-with-margin">Category:</label><br>
                        <div>
                            <select name="category_id" class="nelson-select" id="edit-option-category" required>
                                <option value="" disabled selected>Select category</option>
                                <% for (Category category : categories) { %>
                                <option value="<%= category.getId() %>"><%= category.getName() %></option>
                                <% } %>
                            </select>
                            <a href="#" onclick="extension_toggle('manage-category-extension')"><button class="nelson-button">Manage</button></a>
                            <a href="#" id="edit-prod-category-refresh"><button class="nelson-button">Refresh</button></a>
                        </div>
                        <p id="edit-invalid-category" class="hidden" style="color:red;">Invalid category.</p>
                    </div>
                    <div class="input-field">
                        <label for="sub_images" class="label-with-margin">Images:</label><br>
                        <input id="edit-product-images" autocomplete="off" type="file" name="sub_images" class="nelson-input" accept="image/png, image/jpg, image/jpeg, image/webp" multiple><br>
                        <p id="edit-product-invalid-image" class="hidden" style="color:red;">Invalid image.</p>
                        <div id="edit-images-preview">
                        </div>
                    </div>
                    <div class="input-field">
                        <label for="display_image" class="label-with-margin">Display Image:</label><br>
                        <input id="edit-display-image" autocomplete="off" type="file" name="display_image" class="nelson-input" accept="image/png, image/jpg, image/jpeg, image/webp"><br>
                        <p id="edit-product-invalid-display_image" class="hidden" style="color:red;">Invalid display image.</p>
                        <div id="edit-display-image-preview">
                        </div>
                    </div>
                    <hr>
                    <div class="buttons-field">
                        <button class="nelson-button" id="edit-product-cancel">Cancel</button>
                        <button class="nelson-button" type="reset" id="edit-product-reset">Reset</button>
                        <input type="submit" class="nelson-button" value="Update">
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
